import os
from psycopg2 import connect, connection
from psycopg2.extras import DictCursor


def get_database_connection(db_name: str=None, user: str=None, host: str=None, password: str=None) -> connection:
    """Retrieve the database connection.

    This returns a database connection to the database, not just the database
    server.

    :param db_name:     Name of the database to connect to
    :param user:        Database username
    :param host:        Database host url
    :param password:    Database password

    :return:            A psycopg2 `connection`
    """
    if not host:
        host = os.getenv('POSTGRES_HOST', 'localhost')
    if not db_name:
        db_name = os.getenv('POSTGRES_DB', 'anxiety')
    if not user:
        user = os.getenv('POSTGRES_USER', 'postgres')
    if not password:
        password = os.getenv('POSTGRES_PASSWORD', 'p0stgres')

    return connect(database=db_name, user=user, password=password, host=host, cursor_factory=DictCursor)


def connect_to_database(user: str=None, host: str=None, password: str=None) -> connection:
    """Retrieve a connection to the database server.

    :param user:        Database username
    :param host:        Database host url
    :param password:    Database password

    :return:            A psycopg2 `connection`
    """
    if not host:
        host = os.getenv('POSTGRES_HOST', 'localhost')
    if not user:
        user = os.getenv('POSTGRES_USER', 'postgres')
    if not password:
        password = os.getenv('POSTGRES_PASSWORD', 'p0stgres')

    return connect(user=user, password=password, host=host, cursor_factory=DictCursor)
