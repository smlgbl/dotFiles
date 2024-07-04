function ll --wraps=ls --wraps='ls -Glh' --wraps='exa --group-directories-first --git --long' --description 'alias ll=exa --group-directories-first --git --long'
  exa --group-directories-first --git --long $argv; 
end
