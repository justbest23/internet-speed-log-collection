import pandas as pd

# Load CSV
df = pd.read_csv("speed_data.csv")

# Parse and clean timestamp
df["timestamp"] = pd.to_datetime(df["timestamp"].str[:19].str.replace("T", " "))

# Separate into Fast and Speedtest data
df_fast = df[df["source"] == "fast"][["timestamp", "download_mbps", "upload_mbps"]]
df_speedtest = df[df["source"] == "speedtest"][["timestamp", "download_mbps", "upload_mbps"]]

# Set column names for clarity
df_fast.columns = ["Timestamp", "Download (Mbps)", "Upload (Mbps)"]
df_speedtest.columns = ["Timestamp", "Download (Mbps)", "Upload (Mbps)"]

# Sort data by timestamp (in case it's not already sorted)
df_fast = df_fast.sort_values("Timestamp")
df_speedtest = df_speedtest.sort_values("Timestamp")

# Create an Excel writer
with pd.ExcelWriter("speedtest_data.xlsx", engine="xlsxwriter") as writer:
    # Write both DataFrames to separate sheets in the same Excel file
    df_fast.to_excel(writer, sheet_name="Fast Data", index=False)
    df_speedtest.to_excel(writer, sheet_name="Speedtest Data", index=False)

    # Access the XlsxWriter workbook and add formatting
    workbook  = writer.book
    worksheet_fast = workbook.get_worksheet_by_name("Fast Data")
    worksheet_speedtest = workbook.get_worksheet_by_name("Speedtest Data")

    # Add some formatting for better readability
    format_headers = workbook.add_format({'bold': True, 'bg_color': '#D3D3D3', 'border': 1})
    
    # Apply header formatting to both sheets
    worksheet_fast.set_row(0, None, format_headers)
    worksheet_speedtest.set_row(0, None, format_headers)

    # Set column widths for better readability
    worksheet_fast.set_column('A:A', 20)  # Timestamp column width
    worksheet_fast.set_column('B:B', 15)  # Download column width
    worksheet_fast.set_column('C:C', 15)  # Upload column width

    worksheet_speedtest.set_column('A:A', 20)  # Timestamp column width
    worksheet_speedtest.set_column('B:B', 15)  # Download column width
    worksheet_speedtest.set_column('C:C', 15)  # Upload column width

print("Data has been split and saved into 'speedtest_data.xlsx'.")
