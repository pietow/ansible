git remote -v
git remote set-url origin <SSH GITHUB ADDRESS>
docker build -t test/image .
docker run -it --rm -e "HOME=${HOME}" -v "${HOME}:${HOME}/" -v /etc/group:/etc/group:ro -v /etc/passwd:/etc/passwd:ro -u $(id -u):$(id -g) -w "$(pwd)" test/image
ansible-playbook FILENAME.yml
ansible-playbook  local.yml --ask-vault-pass
eval `ssh-agent -s`
ssh-add ~/.ssh/id_ed25519
sudo npm i -g eslint@^6.1.0 eslint-config-airbnb eslint-plugin-import eslint-plugin-jsx-a11y eslint-plugin-react
tmux ls | grep -Po "^([0-9]{1,2}):" | sed 's/:$//' | xargs -n1 tmux kill-session -t

