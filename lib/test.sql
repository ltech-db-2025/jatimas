WITH pj AS (
    SELECT
        d.idtrans AS idtrans,
        SUM(d.poin) AS poin,
        SUM(p.bayar) AS byrpoin
    FROM
        t
    JOIN d ON d.idtrans = t.id
    LEFT JOIN poind p ON p.id = d.id
    WHERE
        t.kdtrans = 'PJ'
        AND ROUND(d.poin - COALESCE(p.bayar, 0), 0) <> 0
        AND COALESCE(t.saldo, 0) = 0
    GROUP BY
        d.idtrans
),
x AS (
    SELECT
        'PENJUALAN' AS idx,
        t.id AS idtrans,
        t.notrans AS notrans,
        t.tanggal AS tanggal,
        t.idlokasi AS idlokasi,
        t.iddevisi AS iddevisi,
        t.idpegawai AS idpegawai,
        t.idkontak AS idkontak,
        t.keterangan AS keterangan,
        t.nilaitotal AS nilaitotal,
        t.bayar AS bayar,
        t.kredit AS kredit,
        t.potongnota AS potongnota,
        t.pembayaran AS pembayaran,
        t.tempo AS tempo,
        pj.poin AS poin,
        pj.byrpoin AS byrpoin
    FROM
        pj
    JOIN t ON t.id = pj.idtrans

    UNION ALL 

    SELECT
        d.id AS id,
        d.idtrans AS idtrans,
        t.notrans AS notrans,
        t.tanggal AS tanggal,
        t.idlokasi AS idlokasi,
        t.iddevisi AS iddevisi,
        t.idpegawai AS idpegawai,
        t.idkontak AS idkontak,
        CONCAT(d.refnotrans, ': ', d.kode) AS keterangan,
        d.total AS total,
        NULL AS bayar,
        NULL AS kredit,
        NULL AS potongnota,
        NULL AS pembayaran,
        NULL AS tempo,
        -d.poin AS poin,
        NULL AS x
    FROM
        d
    JOIN t ON t.id = d.idtrans
    LEFT JOIN poind pd ON pd.id = d.id
    WHERE
        t.kdtrans = 'RJ'
        AND d.poin - COALESCE(pd.bayar, 0) <> 0
        AND COALESCE(t.saldo, 0) = 0
)

SELECT
    x.idx AS idx,
    x.idtrans AS idtrans,
    x.notrans AS notrans,
    x.tanggal AS tanggal,
    l.id AS idlokasi,
    l.kode AS lokasi,
    x.iddevisi AS iddevisi,
    x.idpegawai AS idpegawai,
    kp.kode AS pegawai,
    x.idkontak AS idkontak,
    kk.kode AS kontak,
    x.keterangan AS keterangan,
    x.nilaitotal AS nilaitotal,
    x.bayar AS bayar,
    x.kredit AS kredit,
    x.potongnota AS potongnota,
    x.pembayaran AS pembayaran,
    x.tempo AS tempo,
    x.poin AS poin,
    x.byrpoin AS byrpoin
FROM
    x
LEFT JOIN ktk kk ON kk.id = x.idkontak
LEFT JOIN ktk kp ON kp.id = x.idpegawai
LEFT JOIN lokasi l ON l.id = x.idlokasi;
