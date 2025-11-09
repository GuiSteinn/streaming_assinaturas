:- dynamic obs/1.

coletar_observacoes :-
    format("Plano atual (basico/padrao/premium): "),
    read(A),
    assertz(obs(plano_atual(A))),

    format("Novo plano desejado (basico/padrao/premium): "),
    read(N),
    assertz(obs(plano_novo(N))),

    format("Quantos dias do mes ja foram usados antes da mudanca?: "),
    read(D),
    assertz(obs(dias_usados(D))).

cleanup :- retractall(obs(_)).
