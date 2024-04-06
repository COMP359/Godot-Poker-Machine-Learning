# Instructions to Install & Use Python venv
Godot Poker Machine Learning

## 1. Creating the virtual environment
- Make sure you have Python 3 installed
- Open terminal and navigate to `Godot-Poker-Machine-Learning/Python-ML/`
- Run the following commands:

```cmd
> python -m venv rl
> rl\Scripts\activate
> pip3 install godot_rl
```

## 2. Using the godot-rl-agents experimental branch
- This branch is required for the training/usage of our AI model
- Go to [this branch](https://github.com/edbeeching/godot_rl_agents/tree/discrete_actions_experimental) (discrete_actions_experimental) of the godot_rl_agents repository, download and extract the ZIP
- Copy the `godot_rl` folder into your venv `rl\Lib\site-packages`, replacing the current `godot_rl` package

## 3. Training the ML model
- Open terminal and navigate to `Godot-Poker-Machine-Learning/Python-ML/`
- Run the following commands:

```cmd
> rl\Scripts\activate
> python "stable_baselines3_example.py"
```
- Wait for terminal prompt to press PLAY in the Godot editor
- Run the project in Godot