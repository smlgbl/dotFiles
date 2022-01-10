function ls --wraps='exa --group-directories-first --git' --description 'alias ls=exa --group-directories-first --git'
  exa --group-directories-first --git $argv; 
end
