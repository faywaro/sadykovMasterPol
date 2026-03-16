using System.ComponentModel;
using System.Linq;
using sadykovMasterPol.Models;
using sadykovMasterPol.Helpers;

namespace sadykovMasterPol.ViewModels
{
    public class PartnerViewModel : INotifyPropertyChanged
    {
        private readonly Partner _partner;

        public PartnerViewModel(Partner partner)
        {
            _partner = partner;
        }

        public int    Id          => _partner.Id;
        public string CompanyName => _partner.CompanyName;
        public string TypeName    => _partner.PartnerType?.TypeName ?? "—";
        public string Director    => _partner.DirectorName;
        public string Phone       => _partner.Phone;
        public int    Rating      => _partner.Rating;
        public string Email       => _partner.Email;
        public string LogoPath    => _partner.LogoPath ?? string.Empty;

        public int TotalSalesQuantity =>
            _partner.Sales?.Sum(s => s.Quantity) ?? 0;

        public int DiscountPercent =>
            DiscountCalculator.CalculateDiscount(TotalSalesQuantity);

        public string DiscountDisplay => $"{DiscountPercent}%";

        public string CardTitle => $"{TypeName} | {CompanyName}";

        public event PropertyChangedEventHandler? PropertyChanged;

        protected void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}
