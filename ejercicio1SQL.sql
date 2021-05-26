SELECT cli.cedula, cli.nombre
FROM  cliente cli
INNER JOIN CUENTA cu ON cli.cedula = cu.cedula AND cu.nombre = 'CENTRO'

WHERE cu.fechaalta IN (
    SELECT MIN(cu.fechaalta) AS fechaalta
    FROM  cliente cli
    INNER JOIN CUENTA cu ON cli.cedula = cu.cedula AND cu.nombre = 'CENTRO'
    )