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

    # save the tasks completed in a csv file
    # format: "USER_ID","USERNAME","TASK_COMPLETED_STATUS","TASK_TITLE"
    with open("{}.csv".format(user_id), "w", newline="") as csvfile:
        writer = csv.writer(csvfile, quoting=csv.QUOTE_ALL)
        [writer.writerow(
            [user_id,
             user_name,
             task.get("completed"),
             task.get("title")]
         ) for task in tasks]
