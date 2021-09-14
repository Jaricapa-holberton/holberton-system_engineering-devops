#!/usr/bin/python3
"""Return information about his/her TODO list progress"""
import json
import requests
from sys import argv


if __name__ == "__main__":
    url = "https://jsonplaceholder.typicode.com/"
    # add the endpoint of user to the link of the api
    uri_user = "users/"
    # add the endpoint of todos to the link of the api
    uri_todos = "todos"

    # get the json of user data
    users = requests.get(url + uri_user).json()
    # set the dictionary of tasks
    dir_user_tasks = {}

    # save the tasks completed in the task dictionary
    # "USER_ID": [ {"username": "USERNAME", "task": "TASK_TITLE",
    # "completed": TASK_COMPLETED_STATUS}, {"username": "USERNAME",
    # "task": "TASK_TITLE", "completed": TASK_COMPLETED_STATUS}, ... ]
    for user in users:
        user_id = user.get("id")
        user_name = user.get("username")
        tasks = requests.get(url + uri_todos,
                             params={"userId": user_id}).json()
        user_tasks = ({user_id: [{"task": task.get("title"),
                                  "completed": task.get("completed"),
                                  "username": user_name} for task in tasks]})
        dir_user_tasks.update(user_tasks)

    # save the dictionary as a json object
    with open("todo_all_employees.json", "w") as jsonfile:
        json.dump(dir_user_tasks, jsonfile)
