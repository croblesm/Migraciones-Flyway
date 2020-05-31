# https://stackoverflow.com/questions/2423777/is-it-possible-to-create-a-remote-repo-on-github-from-the-cli-without-opening-br
# https://stackoverflow.com/questions/28385884/how-to-create-repository-in-github-through-github-api
# https://coderwall.com/p/mnwcog/create-new-github-repo-from-command-line


curl -u 'dbamaster' https://api.github.com/user/repos -d "{\"name\":\"LeTest\"}"
curl -H "Authorization: token c4a544fe50ba6b835c638349231c6a91ffe702c4" --data '{"name":"Migraciones-Flyway"}' https://api.github.com/user/repos


hub create -p