:- dynamic obs/1.

% 1) Mesmo plano: não cobrar nada
meta(resultado(plano_atual(A), plano_novo(A), valor_cobrado(0.0))) :-
    obs(plano_atual(A)),
    obs(plano_novo(A)).

% 2) Troca no dia 0: cobrar o mes completo do novo plano
meta(resultado(plano_atual(_A), plano_novo(N), valor_cobrado(VFinal))) :-
    obs(plano_novo(N)),
    obs(dias_usados(Dias)),
    Dias =:= 0,
    plano(N, ValorN),
    VFinal is round(ValorN * 100) / 100.

% 3) Troca no fim do mes (ou dias usados >= dias do mes): nada a cobrar neste mes
meta(resultado(plano_atual(_A), plano_novo(_N), valor_cobrado(0.0))) :-
    obs(dias_usados(Dias)),
    dias_mes(TotalDias),
    Dias >= TotalDias.

% 4) Promo especial: ao migrar para premium, aplicar 5% de desconto sobre a diferença pró-rata
meta(resultado(plano_atual(A), plano_novo(premium), valor_cobrado(VFinal))) :-
    obs(plano_atual(A)),
    A \= premium,
    obs(plano_novo(premium)),
    obs(dias_usados(Dias)),
    plano(A, ValorA),
    plano(premium, ValorP),
    dias_mes(TotalDias),
    ValorP > ValorA,
    DiasNovo is TotalDias - Dias,
    RawDiff is ((ValorP - ValorA) / TotalDias) * DiasNovo,
    Discounted is RawDiff * 0.95, % 5% off
    VFinal is round(Discounted * 100) / 100.

% 5) Upgrade (novo plano mais caro): cobrar somente a diferença pró-rata pelos dias restantes
meta(resultado(plano_atual(A), plano_novo(N), valor_cobrado(VFinal))) :-
    obs(plano_atual(A)),
    obs(plano_novo(N)),
    A \= N,
    obs(dias_usados(Dias)),
    plano(A, ValorA),
    plano(N, ValorN),
    dias_mes(TotalDias),
    ValorN > ValorA,
    DiasNovo is TotalDias - Dias,
    DeltaPerDay is (ValorN - ValorA) / TotalDias,
    Raw is DeltaPerDay * DiasNovo,
    VFinal is round(Raw * 100) / 100.

% 6) Downgrade (novo plano mais barato): não cobrar neste mes (créditos podem ser tratados separadamente)
meta(resultado(plano_atual(A), plano_novo(N), valor_cobrado(0.0))) :-
    obs(plano_atual(A)),
    obs(plano_novo(N)),
    A \= N,
    obs(dias_usados(_Dias)),
    plano(A, ValorA),
    plano(N, ValorN),
    ValorN < ValorA.

% 7) Troca parcial com dias inválidos (negativos): falha silenciosa (não gera meta)
%    -> Não há regra para dias negativos, assim meta/1 falhará e o sistema informará que não foi possível concluir.

% 8) Regra fallback: cálculo pró-rata original (mantida como último recurso)
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
