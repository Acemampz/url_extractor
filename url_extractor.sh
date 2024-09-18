#!/bin/bash

# Function to display help message
function show_help() {
    echo "Usage: $0 [OPTIONS] input_file"
    echo
    echo "Options:"
    echo "  -h, --help    Display this help message."
    echo
    echo "Description:"
    echo "  This script filters and outputs URLs based on user-defined start and end patterns."
    echo
    echo "Arguments:"
    echo "  input_file    The file containing the URLs to filter."
    echo
    echo "Example:"
    echo "  $0 urls.txt"
    echo
    echo "When prompted for how the URL should end, press 'Enter' if no specific ending is required."
}

# Check if no arguments were provided
if [[ $# -eq 0 ]]; then
    show_help
    exit 1
fi

# Handle help option
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_help
    exit 0
fi

# Input file is the first argument
input_file="$1"

# Check if the input file exists
if [[ ! -f "$input_file" ]]; then
  echo "Error: Input file '$input_file' not found!"
  exit 1
fi

# Prompt the user to enter how the URL should start
read -p "Enter how the URL should start (e.g., http or https): " url_start

# Prompt the user to enter how the URL should end
read -p "Enter how the URL should end (press 'Enter' for no specific ending): " url_end

# Prompt the user for output option: stdout or file
read -p "Do you want to save the output to a file? (y/n): " save_to_file

# If the user chooses to save to file, ask for the filename
if [[ "$save_to_file" == "y" || "$save_to_file" == "Y" ]]; then
    read -p "Enter the output file name: " output_file
fi

# Extract URLs from the file and filter based on user input
if [[ -z "$url_end" ]]; then
    # If no specific ending is provided
    if [[ -n "$output_file" ]]; then
        grep -Eo "$url_start[^ ]*" "$input_file" > "$output_file"
        echo "Filtered output saved to $output_file"
    else
        grep -Eo "$url_start[^ ]*" "$input_file"
    fi
else
    # If both start and end patterns are provided
    if [[ -n "$output_file" ]]; then
        grep -Eo "$url_start[^ ]*$url_end" "$input_file" > "$output_file"
        echo "Filtered output saved to $output_file"
    else
        grep -Eo "$url_start[^ ]*$url_end" "$input_file"
    fi
fi
