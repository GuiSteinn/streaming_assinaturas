:- ["kb.pl","rules.pl","ui.pl","explain.pl"].

start :-
  banner, menu.

banner :-
  format("~n=== Sistema Especialista: Streaming & Assinaturas ===~n"),
  format("Desenvolvido por: Guilherme Sgrott e Samuel Wiggers~n~n").

menu :-
  format("1) Calcular migracao de plano~n2) Sair~n> "),
  read(Opt),
  ( Opt = 1 -> run_case, cleanup, menu
  ; Opt = 2 -> format("Saindo...~n")
  ; format("Opcao invalida.~n"), menu ).

run_case :-
    coletar_observacoes,
    ( meta(Result) ->
        explicar(Result),
        format("~nRESULTADO: ~w~n", [Result])
    ; format("~nNao foi possivel concluir a avaliacao.~n")
    ).
