FROM ubuntu:latest

# Copy your script into the container
COPY ./scripts/test.sh /usr/local/bin/your_script.sh

# Make the script executable
RUN chmod +x /usr/local/bin/your_script.sh

# Set the entrypoint to run your script
ENTRYPOINT ["/usr/local/bin/your_script.sh"]

# If you need to install additional packages (like curl)
RUN apt-get update && apt-get install -y curl

# Set any environment variables
ENV MY_VARIABLE='some_value'