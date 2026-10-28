using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Venta
    {
        public int Id { get; set; }
        public DateTime Fecha { get; set; }
        public Cliente Cliente { get; set; }
        public List<DetalleVenta> Detalle { get; set; }
        public string NroFactura { get; set; }
        public decimal Total { get; set; }
    }
}
