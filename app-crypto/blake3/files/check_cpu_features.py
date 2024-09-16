#!/usr/bin/env python3
import subprocess

# Function to check specific CPU flags using lscpu
def check_cpu_flags():
    try:
        # Run lscpu and capture the output
        output = subprocess.check_output(['lscpu'], universal_newlines=True)

        # Extract the 'Flags' section from the output
        for line in output.splitlines():
            if 'Flags:' in line:
                flags = line.split(':')[1].strip().lower()
                break
        else:
            raise RuntimeError('Unable to find CPU flags in lscpu output.')

        # Check for the desired flags
        features = {
            'sse2': 'sse2' in flags,
            'sse4.1': 'sse4_1' in flags,
            'avx2': 'avx2' in flags,
            'avx512': 'avx512' in flags
        }

        return features
    except subprocess.CalledProcessError as e:
        print(f"Error running lscpu: {e}")
        return None

if __name__ == '__main__':
    features = check_cpu_flags()
    if features:
        for feature, supported in features.items():
            print(f"{feature}: {'Supported' if supported else 'Not supported'}")
