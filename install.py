print("THIS IS INSTALLATION SCRIPT FOR SOME SOFTWARE FOR Debian/Ubuntu")

options = ["All", "Apache2", "PHP", "Composer", "NodeJS", "MySql", "Git"]

selectedOption = input(
    """Select from below options :-
1. Apache2
2. PHP
3. Composer
4. NodeJS
5. MySql
6. Git
0. for all
"""
)
if selectedOption.isdigit():
    selectedOption = int(selectedOption)
    print("We are installing your selected option",options[int(selectedOption)])