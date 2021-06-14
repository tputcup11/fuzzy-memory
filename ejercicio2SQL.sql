/*Obtener todos los datos de los clientes que recibieron depósitos en dólares o depósitos en pesos mayores a mil unidades durante el mes anterior, 
pero que no recibieron depósitos en ambas monedas mayores a dicho monto en ese periodo.
*/

SELECT cl.*

FROM cliente cl
INNER JOIN cuenta cu ON cu.cedula = cl.cedula 
INNER JOIN movimiento m ON m.numero = cu.numero AND m.nombre = cu.nombre

WHERE TO_DATE(LAST_DAY(ADD_MONTHS(CURRENT_DATE,-1))) = TO_DATE(LAST_DAY(m.fecha))
AND cu.moneda IN ('USD','UYU')
AND m.importe > 1000
AND cl.cedula NOT IN (
    --Trae todos los que tienen movimientos en ambas cuentas en el periodo de tiempo indicado, mov. mayores a 1000 unidades.
    SELECT DISTINCT cl.cedula
    FROM cliente cl
    INNER JOIN cuenta cu ON cu.cedula = cl.cedula 
    INNER JOIN movimiento m ON m.numero = cu.numero AND m.nombre = cu.nombre
    
    INNER JOIN (
        --Da resultado si el cliente tiene movimientos en pesos en el periodo.
        SELECT DISTINCT cl.cedula
        FROM cliente cl
        INNER JOIN cuenta cu ON cu.cedula = cl.cedula 
        INNER JOIN movimiento m ON m.numero = cu.numero AND m.nombre = cu.nombre
        WHERE TO_DATE(LAST_DAY(ADD_MONTHS(CURRENT_DATE,-1))) = TO_DATE(LAST_DAY(m.fecha))
        AND cu.moneda = 'UYU'
        AND m.importe > 1000
    ) clMovPesos ON clMovPesos.cedula = cl.cedula
    WHERE TO_DATE(LAST_DAY(ADD_MONTHS(CURRENT_DATE,-1))) = TO_DATE(LAST_DAY(m.fecha))
    AND cu.moneda = 'USD'
    AND m.importe > 1000
);