import { site } from "@/lib/site";

export default function Home() {
  return (
    <main className="mx-auto flex min-h-screen max-w-3xl flex-col justify-center gap-4 px-8">
      <h1 className="text-4xl font-semibold tracking-tight">{site.name}</h1>
      <p className="text-lg text-zinc-600 dark:text-zinc-400">{site.tagline}</p>
      <p className="text-sm text-zinc-500">
        Storefront scaffold. Catalog, cart and the shopping assistant arrive through the AI-SDLC
        loop (intent → spec → plan).
      </p>
    </main>
  );
}
