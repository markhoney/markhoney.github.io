<template>
	<div class="page">
		<template v-for="post in posts">
			<h2>
				<router-link :to="post.path">{{ post.frontmatter.title }}</router-link>
			</h2>
			<p>{{new Date(post.frontmatter.date).toLocaleDateString("en-NZ", {year: 'numeric', month: 'long', day: 'numeric'})}} - <router-link :to="post.path">Read more</router-link></p>
		</template>
	</div>
</template>

<script>
export default {
	computed: {
		posts() {
			return this.$site.pages
				.filter(x => x.path.startsWith('/blog/') && !x.frontmatter.blog_index)
				.sort((a, b) => new Date(b.frontmatter.date) - new Date(a.frontmatter.date));
		}
	}
}
</script>
