=
QUERY({
    QUERY({
        ARRAYFORMULA(EOMONTH(INVESTED!A2:A, 0)),
        INVESTED!C2:C
        }, 
        "
        select Col1, sum(Col2) 
        where Col2 is not null
        group by Col1
        label Col1'Date', sum(Col2)'invest'
        "
    ), 
    QUERY({
        ARRAYFORMULA(EOMONTH(SUBSCRIPTION!A2:A, 0)),
        SUBSCRIPTION!C2:C,
        SUBSCRIPTION!B2:C
        }, 
        "
        select Col1, sum(Col2), Col3
        where Col2 is not null
        group by Col1, Col3
        label Col1'Date', sum(Col2)'expense', Col3'portfolio'
    ")}, 
"
select Col1, Col2, Col4, Col5 
where Col1=Col3
label Col1'END DATE', Col2'INVESTED', Col4'EXPENSE', Col5'PORTFOLIO'
format Col1'DD MMM YYYY'
"
)


=
QUERY({
    QUERY({
        ARRAYFORMULA({"MONTH END"; EOMONTH(INVESTED!A2:A, 0)}),
        INVESTED!C:C
        },
        "
        SELECT Col1, sum(Col2)
        where Col2 is not null
        group by Col1
        label sum(Col2)'INVESTED'
        format Col1'dd mmm yyyy'
        "
    ),
    QUERY({
        ARRAYFORMULA({"MONTH END"; EOMONTH(SUBSCRIPTION!A2:A, 0)}),
        SUBSCRIPTION!B:B,
        SUBSCRIPTION!C:C
        },
        "
        select Col1, sum(Col2), Col3
        where Col2 is not null
        group by Col1, Col3
        label sum(Col2)'expense', Col3'portfolio'
        "
    )
},
"select * where Col1=Col3"
)


=
QUERY(
    {
        ARRAYFORMULA({"MONTH END"; EOMONTH(INVESTED!A2:A, 0)}),
        INVESTED!A:C
    },
    "SELECT Col1, sum(Col4)
    where Col3 is not null
    group by Col1
    label sum(Col4)'INVESTED'
    format Col1'dd mmm yyyy'"
    , 1
)

=
QUERY(
    {
        ARRAYFORMULA({"MONTH END"; EOMONTH(SUBSCRIPTION!A2:A, 0)}),
        SUBSCRIPTION!A:C
    },
    "
    select *
    where Col3 is not null
    "
    , 1
)


=ArrayFormula(
    {
        table1!A1:C3,
        vlookup(table1!A1:A3,table2!A1:C3,COLUMN(Indirect("R1C2:R1C"&COLUMNS(table2!A1:C3),0)),0)
    }
)

=ArrayFormula(
    {
        QUERY(
            {
                ARRAYFORMULA({"MONTH END"; EOMONTH(INVESTED!A2:A, 0)}),
                INVESTED!A:C
            },
            "SELECT Col1, sum(Col4)
            where Col3 is not null
            group by Col1
            label sum(Col4)'INVESTED'
            format Col1'dd mmm yyyy'"
            , 1
        ),
        IFNA(VLOOKUP(G39:G43, D45:F48, COLUMN(INDIRECT("R1C2:R1C"&COLUMNS(D45:F48), 0))), 0)
    }
)

=SUM(INDIRECT("B1:"&ADDRESS(ROW()-1,COLUMN(),4)))



=SORT(
    FILTER('2023'!A2:N, 
    IF(
    (SEARCH(D3, '2023'!A2:A&"|"&'2023'!B2:B)),
    (SEARCH(D3, '2023'!A2:A&"|"&'2023'!B2:B)),
    (SEARCH(G3, '2023'!A2:A&"|"&'2023'!B2:B))
    )
    ), 8, FALSE)


=SORT(
    {
        FILTER('2023'!A2:N, 
            IF(
            ISTEXT(D3),
            (SEARCH(D3, '2023'!A2:A&"|"&'2023'!B2:B)),
            (SEARCH(G3, '2023'!B2:B))
            )
        );
        FILTER('2023'!A2:N, 
            IF(
            ISTEXT(D3),
            (SEARCH(D3, '2023'!A2:A&"|"&'2023'!B2:B)),
            (SEARCH(G3, '2023'!B2:B))
            )
        )
    }
, 8, FALSE)

=VLOOKUP(J3, CONST!D:I, 4, 0)


=SORT(
    FILTER(
        INDIRECT(VLOOKUP("SHEET", A2:B4, 2, 0)), 
        IF(
            ISTEXT(D3),
            (SEARCH(D3, VLOOKUP("SEARCH 1", A2:B4, 2, 0) &"|"& VLOOKUP("SEARCH 2", A2:B4, 2, 0))),
            (SEARCH(G3, INDIRECT(VLOOKUP("SEARCH 1", A2:B4, 2, 0))))
        )
    )
    , 8, FALSE)


=SORT(
    FILTER(
        INDIRECT(VLOOKUP("SHEET", A2:B4, 2, 0)), 
        IF(
            ISTEXT(D3),
            (SEARCH(D3, INDIRECT(VLOOKUP("SEARCH 1", A2:B4, 2, 0)) & "|" & INDIRECT(VLOOKUP("SEARCH 2", A2:B4, 2, 0)))),
            (SEARCH(G3, INDIRECT(VLOOKUP("SEARCH 2", A2:B4, 2, 0))))
        )
    ), 8, FALSE)

=QUERY(
    {
        "&TEXTJOIN("; ", 1, 
        IF(A3:A<>"", "'Week of "&LEFT(A3:A, 5)&"'!A1:D5", ))&
        "
    }, 
    ""where Col1 is not null"", 1
)

=QUERY(
    {
        IMPORTRANGE(INDEX!B2, INDEX!D2);
        IMPORTRANGE(INDEX!B3, INDEX!D3);
        IMPORTRANGE(INDEX!B4, INDEX!D4)
    }, 
    "WHERE Col1 IS NOT NULL"
)

=ARRAYFORMULA(
    IF(B2:B21<>"", 
        IF(AC2:AC21>0,
            "IGST: "&CHAR(9)&TEXT(AC2:AC21, LOOKUP!C2)&CHAR(10)&" ("&TEXT(Y2:Y21, "#.00%")&")",
            "CGST: "&CHAR(9)&TEXT(AA2:AA21, LOOKUP!C2)&CHAR(10)&" ("&TEXT(W2:W21, "#.00%")&")"&CHAR(10)&
            "SGST: "&CHAR(9)&TEXT(AB2:AB21, LOOKUP!C2)&CHAR(10)&" ("&TEXT(X2:X21, "#.00%")&")"
        ), 
        ""
    )
)


=ARRAYFORMULA(
    IF(B2:B21<>"", 
        IF(AC2:AC21>0,
            "IGST: "&CHAR(10)&TEXT(AC2:AC21, LOOKUP!C2)&" ("&TEXT(Y2:Y21, "#.00%")&")",
            "CGST: "&CHAR(10)&TEXT(AA2:AA21, LOOKUP!C2)&" ("&TEXT(W2:W21, "#.00%")&")"&CHAR(10)&
            "SGST: "&CHAR(10)&TEXT(AB2:AB21, LOOKUP!C2)&" ("&TEXT(X2:X21, "#.00%")&")"
        ), 
        ""
    )
)

=ARRAYFORMULA(
    IF(B2:B21<>"", 
        IF(AC2:AC21>0,
            "IGST:"&" ("&TEXT(Y2:Y21, "#.00%")&") "&CHAR(10)&TEXT(AC2:AC21, LOOKUP!C2),
            "CGST:"&" ("&TEXT(W2:W21, "#.00%")&") "&CHAR(10)&TEXT(AA2:AA21, LOOKUP!C2)&CHAR(10)&
            "SGST:"&" ("&TEXT(X2:X21, "#.00%")&") "&CHAR(10)&TEXT(AB2:AB21, LOOKUP!C2)
        ), 
        ""
    )
)



=ARRAYFORMULA(
    IF(ITEMS!B2:B21<>"", 
        TEXT(ITEMS!G2:G21, LOOKUP!C2)&
            IF(ITEMS!K2:K21>0, CHAR(10)&CHAR(10)&"Disc Price"&CHAR(10)&TEXT(ITEMS!P2:P21, LOOKUP!C2), ""),
        ""
    )
)

=ARRAYFORMULA(
    IF(
        ITEMS!B2:B21<>"",
        IF(
            ITEMS!R2:R21>0,
            TEXT(-ITEMS!R2:R21, LOOKUP!C2),
            ""
        ), 
        ""
    )
)



=ARRAYFORMULA(IF('LINE ITEMS'!B1:B21<>"", 'LINE ITEMS'!A1:A21, ""))
=ARRAYFORMULA(IF('LINE ITEMS'!B1:B21<>"", 'LINE ITEMS'!B1:B21, ""))
=ARRAYFORMULA(IF('LINE ITEMS'!B1:B21<>"", 'LINE ITEMS'!C1:C21, ""))
=ARRAYFORMULA(IF('LINE ITEMS'!B1:B21<>"", 'LINE ITEMS'!E1:E21, ""))
=ARRAYFORMULA(IF('LINE ITEMS'!B1:B21<>"", 'LINE ITEMS'!F1:F21, ""))
=ARRAYFORMULA(IF('LINE ITEMS'!B1:B21<>"", 'LINE ITEMS'!G1:G21, ""))
=ARRAYFORMULA(IF('LINE ITEMS'!B1:B21<>"", 'LINE ITEMS'!H1:H21, ""))
=ARRAYFORMULA(IF('LINE ITEMS'!B1:B21<>"", 'LINE ITEMS'!I1:I21, ""))
=ARRAYFORMULA(IF('LINE ITEMS'!B1:B21<>"", 'LINE ITEMS'!J1:J21, ""))
=ARRAYFORMULA(IF('LINE ITEMS'!B1:B21<>"", 'LINE ITEMS'!K1:K21, ""))
=ARRAYFORMULA(IF('LINE ITEMS'!B1:B21<>"", 'LINE ITEMS'!L1:L21, ""))
