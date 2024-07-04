function la --wraps=ls --wraps='ls -Glah' --wraps='exa --group-directories-first --git --long' --wraps='exa --group-directories-first --git --long --all' --description 'alias la=exa --group-directories-first --git --long --all'
  exa --group-directories-first --git --long --all $argv; 
end
