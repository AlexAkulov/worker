from setuptools import setup, find_packages

setup(
    name = "moira",
    version = "1.0.1",
    author = "SKB Kontur",
    author_email = "devops@skbkontur.ru",
    description = "Moira checker and api modules",
    license = "GPLv3",
    keywords = "moira graphite alert monitoring",
    url = "http://github.com/moira-alert/worker",
    packages=find_packages(exclude=['tests']),
    long_description='Please, visit moira.readthedocs.org for more information',
    classifiers=[
        "Development Status :: 5 - Production/Stable",
        "License :: OSI Approved :: GNU General Public License v3 (GPLv3)",
    ],
    entry_points={
        'console_scripts': ['moira-api = moira.api.server:run',
                            'moira-checker = moira.checker.server:run'],
    },
)