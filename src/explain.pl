explicar(resultado(plano_atual(A), plano_novo(N), valor_cobrado(V))) :-
    obs(dias_usados(D)),
    plano(A, VA),
    plano(N, VN),
    dias_mes(T),

    format("~n[Explicacao]~n"),
    format("- Plano anterior: ~w (R$ ~2f/mes)~n", [A, VA]),
    format("- Novo plano: ~w (R$ ~2f/mes)~n", [N, VN]),
    format("- Dias utilizados antes da troca: ~w de ~w~n", [D, T]),
    format("- Foi aplicado calculo de pro-rata (cobranca proporcional).~n"),
    format("- Valor total a cobrar neste mes: R$ ~2f~n", [V]).
