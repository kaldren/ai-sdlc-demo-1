import { describe, expect, it } from "vitest";
import { formatPrice, site } from "./site";

describe("site", () => {
  it("has the Leya tagline", () => {
    expect(site.tagline).toBe("Everything you need, one cart away.");
  });
});

describe("formatPrice", () => {
  it("formats minor units", () => {
    expect(formatPrice(1999)).toBe("€19.99");
  });

  it("rejects non-integer amounts", () => {
    expect(() => formatPrice(19.99)).toThrow();
  });
});
