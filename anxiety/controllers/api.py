from typing import List

from bottle.response import Response
from anxiety.queries.home import GET_COUNTDOWNS

from anxiety.utils.database import get_database_connection


def get_countdowns(response: Response) -> List[dict]:
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
    conn = get_database_connection()
    cur = conn.cursor()

    cur.execute(GET_COUNTDOWNS)

    countdowns = cur.fetchone()

    cur.close()
    conn.close()

    return countdowns['json']
