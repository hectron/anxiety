from json import dumps as to_json
from typing import List

from anxiety.queries.home import GET_COUNTDOWNS, INSERT_COUNTDOWNS
from anxiety.utils.database import get_database_connection


def get_countdowns(response) -> List[dict]:
    """Returns the countdowns for the home page.

    :param response:    Bottle `Response` class
    :return:            A list of dictionaries
    """
    response.add_header('Content-Type', 'application/json')


    return __get_countdowns_from_database()


def __get_countdowns_from_database() -> List[dict]:
    """Returns list of countdowns.

    :return: List[dict]
    """
    countdownts = []

    with get_database_connection() as conn:
        with conn.cursor() as cur:
            cur.execute(GET_COUNTDOWNS)

            countdowns = cur.fetchall()

    return to_json(countdowns[0]['json'])

def insert_countdown(request) -> None:
    """Inserts a countdown into the database.

    :param response:    Bottle `request` class
    """
    post = request.forms

    name = post.get('name')
    end_date = post.get('end_date')

    if not name or not end_date:
        raise ValueError('Missing parameters! {}'.format(' '.join(post.keys())))

    with get_database_connection() as conn:
        with conn.cursor() as cur:
            cur.execute(INSERT_COUNTDOWNS, {
                'name': name,
                'end_date': end_date
            })
