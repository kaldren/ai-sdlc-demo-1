export const site = {
  name: "Leya",
  tagline: "Everything you need, one cart away.",
  // .example is reserved (RFC 2606), so this never resolves to a real site.
  apiBaseUrl: process.env.NEXT_PUBLIC_LEYA_API_URL ?? "http://localhost:8000",
} as const;

/** Formats an amount in minor units (cents) as a price string. Money is never a float in Leya. */
export function formatPrice(minorUnits: number, currency = "EUR", locale = "en-IE"): string {
  if (!Number.isInteger(minorUnits)) {
    throw new Error("formatPrice expects integer minor units");
  }
  return new Intl.NumberFormat(locale, { style: "currency", currency }).format(minorUnits / 100);
}
