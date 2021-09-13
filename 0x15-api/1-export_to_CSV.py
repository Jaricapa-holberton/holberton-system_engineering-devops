#!/usr/bin/python3
"""Return information about his/her TODO list progress"""
import csv
import requests
from sys import argv


if __name__ == "__main__":
    # get the id to search
    user_id = argv[1]

    url = "https://jsonplaceholder.typicode.com/"
    # add the endpoint of user to the link of the api
    uri_user_id = "users/{}".format(user_id)
    # add the endpoint of todos to the link of the api
    uri_todos = "todos"

    # get the json of user data
    user_name = requests.get(url + uri_user_id).json().get("username")
    # get the json of task data of users, as the user id says
    tasks = requests.get(url + uri_todos, params={"userId": user_id}).json()

    # save the tasks completed in a json object
    # { "USER_ID": [{"task": "TASK_TITLE", "completed": TASK_COMPLETED_STATUS,
    # "username": "USERNAME"}, {"task": "TASK_TITLE",
    # "completed": TASK_COMPLETED_STATUS, "username": "USERNAME"}, ... ]}
    with open("{}.json".format(user_id), "w", newline="") as jsonfile:
        json.dump({user_id: [{"task": task.get("title"),
                              "completed": task.get("completed"),
                              "username": user_name} for task in tasks]},
                  jsonfile)
