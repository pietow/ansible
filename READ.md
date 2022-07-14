git remote -v
git remote set-url origin <SSH GITHUB ADDRESS>
docker build -t test/image .
docker run -it --rm -e "HOME=${HOME}" -v "${HOME}:${HOME}/" -v /etc/group:/etc/group:ro -v /etc/passwd:/etc/passwd:ro -u $(id -u):$(id -g) -w "$(pwd)" test/image
ansible-playbook FILENAME.yml
ansible-playbook  local.yml --ask-vault-pass

