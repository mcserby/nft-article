FROM ubuntu:latest
RUN export DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt -qy install xxd
RUN apt -qy install python3.9
RUN apt -qy install python3.9-venv
RUN apt -qy install bc
RUN apt -qy install vim
COPY /erdpy-up/erdpy-up.py erdpy-up/erdpy-up.py
RUN useradd --create-home -u 1111 main
USER main
RUN python3.9 erdpy-up/erdpy-up.py
COPY walletKey.pem /home/main/elrondsdk/walletKey.pem
COPY issue_collection.sh /home/main/elrondsdk/issue_collection.sh
COPY set_nft_special_role.sh /home/main/elrondsdk/set_nft_special_role.sh
COPY generate_nft.sh /home/main/elrondsdk/generate_nft.sh
WORKDIR /home/main/elrondsdk/