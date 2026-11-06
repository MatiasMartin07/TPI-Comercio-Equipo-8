using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class DetalleCompra : Producto
    {
        public int IdDetalleCompra { get; set; }
        public Producto producto { get; set; } 
        public int Cantidad { get; set; }
        public decimal PrecioUnitario { get; set; }
        public decimal subtotal { get; set; }
    }
}
