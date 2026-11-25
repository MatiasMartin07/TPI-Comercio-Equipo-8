using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Compras
    {
        public int IdCompra { get; set; }
        public DateTime Fecha { get; set; }
        public Proveedores Proveedor { get; set; }
        public List<DetalleCompra> Detalles { get; set; }
        public decimal Total { get; set; }
    }
}
