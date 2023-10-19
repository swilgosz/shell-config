# default docker-compose commands
alias dc='docker-compose'
alias dcs='docker-compose up -d'
alias dcr='docker-compose run --rm' # runs the given service, i.e: dcr api
alias dce='docker-compose exec'     # runs command in the running container, usage: dce api bash
alias dcl='docker-compose logs -f'  # shows log of the given service. usage: dcl api

# production-specific docker-compose commands
alias dcp='docker-compose -f docker-compose.prod.yml'
alias dcps='docker-compose -f docker-compose.prod.yml up -d'
alias dcpr='docker-compose -f docker-compose.prod.yml run --rm'
alias dcpe='docker-compose -f docker-compose.prod.yml exec'
alias dcpl='docker-compose -f docker-compose.prod.yml logs -f'

drun(){
  docker exec -it $1 $2
}

alias dlogs='docker logs -f'

# Docker-sync setup
alias ds='docker-sync'
alias dsst='docker-sync start'
alias dssp='docker-sync stop'
alias dsc='docker-sync clean'
alias dsr='dssp && dsst'
alias dscr='dssp && dsc && dsst'