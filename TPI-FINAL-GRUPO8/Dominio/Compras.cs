using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Compras : Proveedores
    {
        public int IdCompras { get; set; }
        public DateTime Fecha { get; set; }
        public Proveedores proveedor { get; set; }
        public List<DetalleCompra> Detalle { get; set; }
        public decimal Total { get; set; }
    }
}
