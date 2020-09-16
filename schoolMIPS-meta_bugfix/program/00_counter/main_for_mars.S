

            .text

start:      move    $v0, $0
counter:    addiu   $v0, $v0, 1
            b       counter
