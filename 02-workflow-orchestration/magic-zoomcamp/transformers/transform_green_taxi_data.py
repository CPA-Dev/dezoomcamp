import re

if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


def camel_to_snake(column_name):
    snake_case = re.sub('([a-z0-9])([A-Z])', r'\1_\2', column_name)
    return snake_case.lower()
    
@transformer
def transform(data, *args, **kwargs):
    count = data[(data['passenger_count']<=0) | (data['trip_distance'] <= 0.0)].shape[0]
    print(f"Preprocessing: rows with zero passengers: {count}")
    
    data['lpep_pickup_date'] = data['lpep_pickup_datetime'].dt.date

    data = data.rename(columns={col: camel_to_snake(col) for col in data.columns})

    return data[(data['passenger_count'] > 0) & (data['trip_distance'] > 0.0)]


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output[~output['vendor_id'].isin([1,2])].shape[0] == 0, 'There is vendor_id not in existing value'
    assert output['passenger_count'].isin([0]).sum() == 0, 'There are rides with zero passengers'
    assert output['trip_distance'].isin([0.0]).sum() == 0, 'There are rides with zero distance'
