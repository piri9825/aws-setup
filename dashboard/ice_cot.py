import dash
from dash import dcc, html, dash_table
import boto3
import pandas as pd

dynamodb = boto3.resource("dynamodb", region_name="eu-north-1")
table = dynamodb.Table("aws-setup-dynamodb")


def get_data():
    response = table.scan()
    items = response.get("Items", [])
    return pd.DataFrame(items)


app = dash.Dash(__name__)

app.layout = html.Div(
    [
        html.H1("ICE COT"),
        dcc.Interval(id="interval", interval=10000, n_intervals=0),
        dash_table.DataTable(
            id="data-table",
            columns=[
                {"name": "Market", "id": "Market"},
                {"name": "Date", "id": "Date"},
                {"name": "OI_All", "id": "OI_All"},
            ],
            style_table={"overflowX": "auto"},
            style_cell={"textAlign": "center"},
        ),
    ]
)


@app.callback(
    dash.Output("data-table", "data"), [dash.Input("interval", "n_intervals")]
)
def update_table(_):
    df = get_data()
    return df.to_dict("records")
