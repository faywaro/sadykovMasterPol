using NUnit.Framework;
using sadykovMasterPol.Helpers;

namespace sadykovMasterPol.Tests
{
    [TestFixture]
    public class DiscountCalculatorTests
    {

        [Test]
        public void CalculateDiscount_ZeroQuantity_ReturnsZeroPercent()
        {
            int result = DiscountCalculator.CalculateDiscount(0);
            Assert.That(result, Is.EqualTo(0));
        }

        [Test]
        public void CalculateDiscount_NegativeQuantity_ReturnsZeroPercent()
        {
            int result = DiscountCalculator.CalculateDiscount(-100);
            Assert.That(result, Is.EqualTo(0));
        }

        [Test]
        public void CalculateDiscount_LessThan10000_ReturnsZeroPercent()
        {
            Assert.That(DiscountCalculator.CalculateDiscount(9_999),  Is.EqualTo(0));
            Assert.That(DiscountCalculator.CalculateDiscount(1),      Is.EqualTo(0));
            Assert.That(DiscountCalculator.CalculateDiscount(5_000),  Is.EqualTo(0));
        }

        [Test]
        public void CalculateDiscount_Exactly10000_ReturnsFivePercent()
        {
            int result = DiscountCalculator.CalculateDiscount(10_000);
            Assert.That(result, Is.EqualTo(5));
        }

        [Test]
        public void CalculateDiscount_Between10000And49999_ReturnsFivePercent()
        {
            Assert.That(DiscountCalculator.CalculateDiscount(10_001),  Is.EqualTo(5));
            Assert.That(DiscountCalculator.CalculateDiscount(25_000),  Is.EqualTo(5));
            Assert.That(DiscountCalculator.CalculateDiscount(49_999),  Is.EqualTo(5));
        }

        [Test]
        public void CalculateDiscount_Exactly50000_ReturnsTenPercent()
        {
            int result = DiscountCalculator.CalculateDiscount(50_000);
            Assert.That(result, Is.EqualTo(10));
        }

        [Test]
        public void CalculateDiscount_Between50000And299999_ReturnsTenPercent()
        {
            Assert.That(DiscountCalculator.CalculateDiscount(50_001),   Is.EqualTo(10));
            Assert.That(DiscountCalculator.CalculateDiscount(150_000),  Is.EqualTo(10));
            Assert.That(DiscountCalculator.CalculateDiscount(299_999),  Is.EqualTo(10));
        }

        [Test]
        public void CalculateDiscount_Exactly300000_ReturnsFifteenPercent()
        {
            int result = DiscountCalculator.CalculateDiscount(300_000);
            Assert.That(result, Is.EqualTo(15));
        }

        [Test]
        public void CalculateDiscount_MoreThan300000_ReturnsFifteenPercent()
        {
            Assert.That(DiscountCalculator.CalculateDiscount(300_001),   Is.EqualTo(15));
            Assert.That(DiscountCalculator.CalculateDiscount(1_000_000), Is.EqualTo(15));
        }

        [TestCase(0,         ExpectedResult = 0)]
        [TestCase(9_999,     ExpectedResult = 0)]
        [TestCase(10_000,    ExpectedResult = 5)]
        [TestCase(49_999,    ExpectedResult = 5)]
        [TestCase(50_000,    ExpectedResult = 10)]
        [TestCase(299_999,   ExpectedResult = 10)]
        [TestCase(300_000,   ExpectedResult = 15)]
        [TestCase(999_999,   ExpectedResult = 15)]
        public int CalculateDiscount_ParametrizedCases_ReturnsCorrectDiscount(int quantity)
        {
            return DiscountCalculator.CalculateDiscount(quantity);
        }
    }
}
