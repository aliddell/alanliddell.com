### A Pluto.jl notebook ###
# v0.14.4

using Markdown
using InteractiveUtils

# ╔═╡ 6e221d46-a7c2-11eb-1862-a99748544e89
using ApproxFun, Plots

# ╔═╡ 349d5de4-54b4-44e0-826a-a9de784be526
md"""Let's let $n = 16$.
We'll generate the $n + 1$ Chebyshev points on the interval $[-1, 1]$ and plot them below.
"""

# ╔═╡ 8c03a235-48e0-495a-bf70-8f2ce8bfc16d
begin
	n = 16
	pts = chebyshevpoints(n + 1)
	plot(pts, cos.(pts); seriestype=:scatter)
	plot!(-1:0.01:1, cos.(-1:0.01:1))
end

# ╔═╡ Cell order:
# ╠═6e221d46-a7c2-11eb-1862-a99748544e89
# ╟─349d5de4-54b4-44e0-826a-a9de784be526
# ╠═8c03a235-48e0-495a-bf70-8f2ce8bfc16d
