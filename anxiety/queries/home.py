GET_COUNTDOWNS = '''
SELECT
    array_agg(
        json_build_object(
            'name', name,
            'end_date', end_date
        )
    ) AS json
FROM
    countdowns
'''
