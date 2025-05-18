import re
import os
import requests
import shutil
import glob
from bs4 import BeautifulSoup

# Load GitHub and GitLab tokens from environment variables
GITHUB_TOKEN = os.getenv('GITHUB_TOKEN')
GITLAB_TOKEN = os.getenv('GITLAB_TOKEN')

# Repo path
REPO_PATH = "/var/db/repos/bp"  # Path to your repository

def process_filename(filename):
    """
    Process the filename according to the versioning rules.
    """
    # Define versioning patterns
    simple_version_pattern = r'(\d+\.\d+)(?=\.[^\.]+$)'
    date_version_pattern = r'(\d+\.\d+\.\d{4}\.\d{2}\.\d{2})(?=\.[^\.]+$)'  # Ignore date-based
    revision_version_pattern = r'(\d{8})(-r\d+)?(?=\.[^\.]+$)'  # Ignore revision-based
    rolling_version_pattern = r'(\d{4})\.9999(?=\.[^\.]+$)'  # Ignore rolling releases
    prerelease_version_pattern = r'(\d{4}\d{2}\d{2})(?=\.[^\.]+$)'  # Ignore pre-release versions
    patch_version_pattern = r'(\d+\.\d+)_p(\d+)(?=\.[^\.]+$)'  # Ignore patch versions
    fixed_version_pattern = r'(\d+\.\d+)(?=\.[^\.]+$)'  # Fixed version

    # Match date-based versions (e.g., binutils-2.43.20250223.ebuild)
    if re.search(date_version_pattern, filename):
        print(f"Ignoring date-based version: {filename}")
        return None

    # Match revision-based versions (e.g., flex-20250114-r9.ebuild)
    if re.search(revision_version_pattern, filename):
        print(f"Ignoring revision-based version: {filename}")
        return None

    # Match rolling release versions (e.g., keepassxc-9999.ebuild)
    if re.search(rolling_version_pattern, filename):
        print(f"Ignoring rolling release version: {filename}")
        return None

    # Match pre-release versions (e.g., python-exec-20230320.ebuild)
    if re.search(prerelease_version_pattern, filename):
        print(f"Ignoring pre-release version: {filename}")
        return None

    # Match patch versions (e.g., unzip-6.0_p28.ebuild)
    if re.search(patch_version_pattern, filename):
        print(f"Ignoring patch version: {filename}")
        return None

    # For Simple versioning, process normally (e.g., autoconf-2.72.ebuild)
    if re.search(simple_version_pattern, filename):
        print(f"Processing simple version: {filename}")
        return filename  # Return as is for simple versioning

    # Fixed version should be treated as simple versioning (e.g., protobuf-30.0.ebuild)
    if re.search(fixed_version_pattern, filename):
        print(f"Processing fixed version (treated as simple version): {filename}")
        return filename  # Treat as simple versioning

    # If no match, we just ignore
    print(f"Ignoring unknown version format: {filename}")
    return None


def extract_snapshot_and_url(ebuild_file_path):
    """
    Extract the SNAPSHOT value and SRC_URI from the ebuild file.
    """
    with open(ebuild_file_path, 'r') as file:
        content = file.read()

    # Extract SNAPSHOT using regex
    snapshot_match = re.search(r'SNAPSHOT=([a-f0-9]+)', content)
    if snapshot_match:
        snapshot = snapshot_match.group(1)
        print(f"SNAPSHOT found: {snapshot}")

        # Construct the SRC_URI based on the SNAPSHOT value
        src_uri = f"https://github.com/gcc-mirror/gcc/archive/{snapshot}.tar.gz"
        print(f"SRC_URI: {src_uri}")

        # Extract the S variable (source directory) if present
        source_dir_match = re.search(r'S=${WORKDIR}/([a-zA-Z0-9\-]+)', content)
        if source_dir_match:
            source_dir = source_dir_match.group(1)
            print(f"Source directory: {source_dir}")
        else:
            source_dir = "unknown"
            print("Source directory not found.")

        return snapshot, src_uri, source_dir
    else:
        print("No SNAPSHOT found in ebuild.")
        return None, None, None


def handle_github(repo_url):
    """
    Handle GitHub API to fetch the latest release version
    """
    repo_slug = repo_url.split("github.com/")[1]  # Extract slug from the URL
    releases_api_url = f"https://api.github.com/repos/{repo_slug}/releases/latest"
    headers = {"Authorization": f"token {GITHUB_TOKEN}"}

    response = requests.get(releases_api_url, headers=headers)
    if response.status_code == 200:
        latest_release_info = response.json()
        latest_version = latest_release_info['tag_name'].lstrip('v')  # Remove "v" if present
        print(f"Latest GitHub version: {latest_version}")
        return latest_version
    else:
        print(f"Error fetching version from GitHub: {response.status_code}")
        return None


def handle_gitlab(repo_url):
    """
    Handle GitLab API to fetch the latest release version
    """
    repo_slug = repo_url.split("gitlab.com/")[1]  # Extract slug from the URL
    releases_api_url = f"https://gitlab.com/api/v4/projects/{repo_slug}/releases"
    headers = {"Authorization": f"Bearer {GITLAB_TOKEN}"}

    response = requests.get(releases_api_url, headers=headers)
    if response.status_code == 200:
        latest_release_info = response.json()
        latest_version = latest_release_info[0]['tag_name']
        print(f"Latest GitLab version: {latest_version}")
        return latest_version
    else:
        print(f"Error fetching version from GitLab: {response.status_code}")
        return None


def scrape_download_page(url):
    """
    Scrape the download page to fetch the latest version.
    """
    response = requests.get(url)
    if response.status_code == 200:
        soup = BeautifulSoup(response.text, 'html.parser')

        # Try to find the version information in the page
        # Modify this based on the structure of the HTML for the project
        version_tag = soup.find("a", href=True, text=re.compile(r'\d+\.\d+(\.\d+)?'))
        if version_tag:
            latest_version = version_tag['href'].split('/')[-1].replace('v', '')  # Remove "v" if present
            print(f"Scraped version from page: {latest_version}")
            return latest_version
        else:
            print("Failed to find the version on the page.")
            return None
    else:
        print(f"Error fetching the download page: {response.status_code}")
        return None


def update_ebuild(package_path, package_name, latest_version):
    """
    Simulate the update of an ebuild file by renaming it with the new version.
    """
    new_filename = f"{package_name}-{latest_version}.ebuild"
    print(f"Updating {package_name} to {latest_version}...")

    old_filename = os.path.join(package_path, f"{package_name}-[0-9]*.ebuild")
    ebuild_files = sorted(glob.glob(old_filename), reverse=True)

    if ebuild_files:
        old_filename = ebuild_files[0]
        if old_filename != new_filename:
            shutil.move(old_filename, os.path.join(package_path, new_filename))
            print(f"Renamed {old_filename} to {new_filename}")
        else:
            print(f"{package_name} is already up to date.")
    else:
        print(f"No existing ebuild found for {package_name}.")


def scan_and_process_files():
    """
    Process all ebuild files in the specified directory.
    """
    for root, dirs, files in os.walk(REPO_PATH):
        for filename in files:
            if filename.endswith('.ebuild'):
                processed_filename = process_filename(filename)
                if processed_filename:
                    print(f"File to be processed: {processed_filename}")
                    # Extract SNAPSHOT and SRC_URI from the ebuild file
                    ebuild_file_path = os.path.join(root, filename)
                    snapshot, src_uri, source_dir = extract_snapshot_and_url(ebuild_file_path)

                    # Try to fetch the latest version from GitHub or GitLab
                    repo_url = 'https://github.com/gcc-mirror/gcc'  # Modify as necessary
                    latest_version = handle_github(repo_url)

                    if not latest_version:
                        # Fallback to scraping the download page if GitHub API fails
                        latest_version = scrape_download_page(src_uri)

                    if latest_version:
                        update_ebuild(root, filename, latest_version)


# Main execution
if __name__ == "__main__":
    scan_and_process_files()
