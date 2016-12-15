GET_COUNTDOWNS = '''
SELECT
    array_agg(
        json_build_object(
            'id', id,
            'name', name,
            'end_date', end_date
        )
    ) AS json
FROM
    countdowns
'''

INSERT_COUNTDOWNS = '''
INSERT INTO countdowns (
    name,
    end_date
) VALUES (
    %(name)s,
    %(end_date)s
)
'''
