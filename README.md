# nft-article
nft article pieces of code, scripts, readme

Docker commands:

docker build --no-cache -t nft-main-net:1.0 . 

docker run -v "d:/docker-volumes/files/":/files --name nft-main-net -it nft-main-net:1.0 bash
 
docker exec -it nft-main-net bash

Collection identifier:
SERBDID-e4ae1d

./issue_collection.sh

./set_nft_special_role.sh SERBDID-e4ae1d

./generate_nft <collection_cid> SERBDID-e4ae1d 
