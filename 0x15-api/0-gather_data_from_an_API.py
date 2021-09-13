#!/usr/bin/python3
"""Return information about his/her TODO list progress"""
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
    user = requests.get(url + uri_user_id).json()
    # get the json of task data of users, as the user id says
    tasks = requests.get(url + uri_todos, params={"userId": user_id}).json()

    # check what tasks were completed of the user
    tasks_completed = [task for task in tasks if task.get("completed") is True]

    # print the task completed
    # Employee NAME is done with tasks(DONE_TASKS/TASKS)
    # look for the values of name and lenght of the json tasks
    print("Employee {} is done with tasks({}/{}):".format(user.get("name"),
                                                          len(tasks_completed),
                                                          len(tasks)))

    # print the tasks completed
    [print("\t {}".format(task.get("title"))) for task in tasks_completed]
