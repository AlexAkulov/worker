from setuptools import setup, find_packages
from subprocess import check_output

required = []

with open('requirements.txt') as f:
    required = f.read().splitlines()

def git_version():
    command = "git describe --always --tag"
    v = check_output(command.split()).decode('utf-8').strip().strip('v')
    if len(v) == 1:
        version = v
    else:
        v = v.split('-')
        v[2] = v[2].lstrip('g')
        version = "{v[0]}.dev{v[1]}+{v[2]}".format(v=v)
    print(version)
    return version

setup(
    name = "moira_worker",
    author = "SKB Kontur",
    version = git_version(),
    author_email = "devops@skbkontur.ru",
    description = "Moira checker and api modules",
    license = "GPLv3",
    keywords = "moira graphite alert monitoring",
    url = "https://github.com/moira-alert",
    packages=find_packages(exclude=['tests']),
    long_description='Please, visit moira.readthedocs.org for more information',
    classifiers=[
        "Development Status :: 5 - Production/Stable",
        "License :: OSI Approved :: GNU General Public License v3 (GPLv3)",
    ],
    entry_points={
        'console_scripts': ['moira-api = moira.api.server:run',
                            'moira-checker = moira.checker.server:run',
                            'moira-update = moira.tools.converter:run'],
    },
    install_requires=required,
)
