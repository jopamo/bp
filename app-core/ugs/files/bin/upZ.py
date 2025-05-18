import os
import re
import requests
import shutil
import glob
from datetime import datetime
from bs4 import BeautifulSoup
import sys

GITHUB_TOKEN = os.getenv('GITHUB_TOKEN')
GITLAB_TOKEN = os.getenv('GITLAB_TOKEN')

REPO_PATH = "/var/db/repos/bp"
PROGNAME = "upApp"
TMP_DIR = f"/tmp/{PROGNAME}"

DEBUG_LOG = f"{TMP_DIR}/{PROGNAME}-debug.log"
ERROR_LOG = f"{TMP_DIR}/{PROGNAME}-error.log"
JSON_LOG = f"{TMP_DIR}/{PROGNAME}-json.log"

os.makedirs(TMP_DIR, exist_ok=True)
with open(DEBUG_LOG, 'w'), open(ERROR_LOG, 'w'), open(JSON_LOG, 'w'):
    pass

DRY_RUN = '--dry-run' in sys.argv

def log(message, log_file=DEBUG_LOG):
    with open(log_file, 'a') as f:
        f.write(f"{datetime.now()} - {message}\n")
    print(message)

def handle_github(repo_url):
    repo_slug = repo_url.split("github.com/")[1]
    releases_api_url = f"https://api.github.com/repos/{repo_slug}/releases/latest"
    headers = {"Authorization": f"token {GITHUB_TOKEN}"}

    response = requests.get(releases_api_url, headers=headers)
    if response.status_code == 200:
        latest_release_info = response.json()
        latest_version = latest_release_info['tag_name'].lstrip('v')
        log(f"GitHub latest release: {latest_version}")
        return latest_version
    else:
        log(f"Error fetching GitHub release info: {response.status_code}")
        return None

def handle_gitlab(repo_url):
    repo_slug = repo_url.split("gitlab.com/")[1]
    api_url = f"https://gitlab.com/api/v4/projects/{repo_slug}/releases"
    headers = {"Authorization": f"Bearer {GITLAB_TOKEN}"}

    response = requests.get(api_url, headers=headers)
    if response.status_code == 200:
        latest_release_info = response.json()
        latest_version = latest_release_info[0]['tag_name']
        log(f"GitLab latest release: {latest_version}")
        return latest_version
    else:
        log(f"Error fetching GitLab release info: {response.status_code}")
        return None

def scrape_download_page(url):
    response = requests.get(url)
    if response.status_code == 200:
        soup = BeautifulSoup(response.text, 'html.parser')
        version_tag = soup.find("a", href=True, text=re.compile(r'\d+\.\d+(\.\d+)?'))
        if version_tag:
            latest_version = version_tag['href'].split('/')[-1].replace('v', '')
            log(f"Scraped version from page: {latest_version}")
            return latest_version
        else:
            log(f"Failed to find version on page {url}.")
            return None
    else:
        log(f"Failed to fetch the download page: {url}")
        return None

def update_ebuild(package_path, package_name, latest_version):
    new_filename = f"{package_name}-{latest_version}.ebuild"
    log(f"Updating ebuild for {package_name} to {latest_version}...")

    old_filename = os.path.join(package_path, f"{package_name}-[0-9]*.ebuild")
    ebuild_files = sorted(glob.glob(old_filename), reverse=True)

    if ebuild_files:
        old_filename = ebuild_files[0]
        if old_filename != new_filename:
            if not DRY_RUN:
                shutil.move(old_filename, os.path.join(package_path, new_filename))
            log(f"Renamed {old_filename} to {new_filename}")
        else:
            log(f"{package_name} is already up-to-date.")
    else:
        log(f"No existing ebuild found for {package_name}.")

def process_filename(filename):
    simple_version_pattern = r'(\d+\.\d+)(?=\.[^\.]+$)'
    date_version_pattern = r'(\d+\.\d+\.\d{4}\.\d{2}\.\d{2})(?=\.[^\.]+$)'
    revision_version_pattern = r'(\d{8})(-r\d+)?(?=\.[^\.]+$)'
    rolling_version_pattern = r'(\d{4})\.*9999(?=\.[^\.]+$)'
    prerelease_version_pattern = r'(\d{4}\d{2}\d{2})(?=\.[^\.]+$)'
    patch_version_pattern = r'(\d+\.\d+)_p(\d+)(?=\.[^\.]+$)'
    fixed_version_pattern = r'(\d+\.\d+)(?=\.[^\.]+$)'

    if re.search(date_version_pattern, filename):
        log(f"Ignoring date-based version: {filename}")
        return None
    if re.search(revision_version_pattern, filename):
        log(f"Ignoring revision-based version: {filename}")
        return None
    if re.search(rolling_version_pattern, filename):
        log(f"Ignoring rolling release version: {filename}")
        return None
    if re.search(prerelease_version_pattern, filename):
        log(f"Ignoring pre-release version: {filename}")
        return None
    if re.search(patch_version_pattern, filename):
        log(f"Ignoring patch version: {filename}")
        return None

    if re.search(simple_version_pattern, filename) or re.search(fixed_version_pattern, filename):
        log(f"Processing version: {filename}")
        return filename

    log(f"Ignoring unknown version format: {filename}")
    return None

def extract_url_and_repo(ebuild_file_path):
    with open(ebuild_file_path, 'r') as file:
        content = file.read()

    log(f"Processing ebuild file: {ebuild_file_path}")

    repo_url_match = re.search(r'SRC_URI="(https://[^"]+)', content)
    if repo_url_match:
        repo_url = repo_url_match.group(1)
        log(f"Repository URL found: {repo_url}")

        filename = os.path.basename(ebuild_file_path)
        pn_version = filename.replace('.ebuild', '')

        pn = pn_version.split('-')[0]
        p = pn_version

        repo_url = repo_url.replace("${PN}", pn)
        repo_url = repo_url.replace("${P}", p)
        log(f"Processed SRC_URI: {repo_url}")

        return repo_url
    else:
        log(f"No SRC_URI found in ebuild: {ebuild_file_path}")
        return None

def scan_and_process_files():
    for root, dirs, files in os.walk(REPO_PATH):
        for filename in files:
            if filename.endswith('.ebuild'):
                processed_filename = process_filename(filename)
                if processed_filename:
                    ebuild_file_path = os.path.join(root, filename)
                    repo_url = extract_url_and_repo(ebuild_file_path)

                    if not repo_url:
                        log(f"Skipping file {filename} due to missing SRC_URI.")
                        continue

                    if 'github.com' in repo_url:
                        latest_version = handle_github(repo_url)
                    elif 'gitlab.com' in repo_url:
                        latest_version = handle_gitlab(repo_url)
                    else:
                        latest_version = scrape_download_page(repo_url)

                    if latest_version:
                        update_ebuild(root, filename, latest_version)

                        if not DRY_RUN:
                            os.system(f"cd {root} && pkgdev manifest")

                        if DRY_RUN:
                            log(f"Dry run: would update {filename} to {latest_version}")

if __name__ == "__main__":
    scan_and_process_files()
