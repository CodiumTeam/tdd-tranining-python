class RomanNumerals:

    def convert(self, decimal: int) -> str:
        if decimal == 1:
            return "I" + self.convert(decimal-1)
        if decimal == 2:
            return "I" + self.convert(decimal-1)
        if decimal == 3:
            return "I" + self.convert(decimal-1)
        return ""
