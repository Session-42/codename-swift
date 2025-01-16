// Font weight mapping to Poppins font family names
const FONT_FAMILIES = {
  Light: 'PoppinsLight',
  Regular: 'PoppinsRegular',
  Medium: 'PoppinsMedium',
  SemiBold: 'PoppinsSemiBold',
  Bold: 'PoppinsBold',
};

export const HitCraftFonts = {
  /**
   * Helper function to generate font styles
   * @param {number} size - Font size in pixels
   * @param {string} weight - Font weight (Light, Regular, Medium, SemiBold, Bold)
   * @returns {Object} Font style object
   */
  poppins: (size, weight = 'Regular') => ({
    fontFamily: FONT_FAMILIES[weight] || FONT_FAMILIES.Regular,
    fontSize: size,
  }),
};