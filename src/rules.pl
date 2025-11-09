:- dynamic obs/1.

meta(resultado(plano_atual(A), plano_novo(N), valor_cobrado(VFinal))) :-
    obs(plano_atual(A)),
    obs(plano_novo(N)),
    obs(dias_usados(Dias)),
    plano(A, ValorA),
    plano(N, ValorN),
    dias_mes(TotalDias),

    ParcialAntigo is (ValorA / TotalDias) * Dias,
    DiasNovo is TotalDias - Dias,
    ParcialNovo is (ValorN / TotalDias) * DiasNovo,

    VFinal is round((ParcialAntigo + ParcialNovo) * 100) / 100.
