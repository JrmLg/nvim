" Regex au format regex101
" Pour convertire en regex vim :
"     - Retirer les commentaire et les espaces
"     - Ajouter le mode very magic \v
"
" (([-\+](\s*\()*|[-\+\(])\s*)?                            # Début d'expression
" ([0-9\.]+\s*)                                                 # Premier nombre obligatoire
" (                                 # Recherche du deuxième nombre obligatoire + suite
"     \s*          #Absorbe les espaces à gauche
"         [-\+\/*]\s*             # Une opération suivit d'espace ou non
"             (
"                  (\(\s*)*[0-9\.]+         # avant une ( forcément suivi d'un nombre ou (
"             |                        # Ou
"                  [0-9\.]*                 # devant un autre nombre
"             )
"             (\s*\))*                 # Fermeture optionnel )
" )+


" Sélectionne une expression mathématique dans la ligne courante
function SelectMathExpression()
    let start_line = line('.')
    let start_col = col(".")
    call cursor(start_line, 1)
    let re = '\v(([-\+](\s*\()*|[-\+\(])\s*)?([0-9\.]+\s*)(\s*[-\+\/*]\s*((\(\s*)*[0-9\.]+|[0-9\.]*)(\s*\))*)+'

    let [_, end_match] = searchpos(re, 'ne', start_line)
    if (end_match)
        call search(re, '', start_line)
        normal v
        if &selection == 'inclusive'
            let end_match = end_match - 1
        endif 
        call cursor(start_line, end_match)
        normal l
    endif
endfunction
