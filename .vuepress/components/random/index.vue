<template>
	<div class="page">
		<ul>
			<li v-for="post in posts">
				<h2><router-link :to="post.path">{{ post.frontmatter.title }}</router-link></h2>
			</li>
		</ul>
	</div>
</template>

<script>
export default {
	computed: {
		posts() {
			return this.$site.pages.filter(x => x.path.startsWith('/random/') && !x.frontmatter.blog_index);
		}
	}
}
</script>
