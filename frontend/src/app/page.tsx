"use client";

import { useState, useEffect } from "react";
import {
	BarChart3,
	Calendar,
	TrendingUp,
	Zap,
	Target,
	Users,
	Brain,
	CheckCircle,
	ArrowRight,
	ExternalLink,
	Sparkles,
	Play,
	Activity,
} from "lucide-react";

export default function Dashboard() {
	const [activeTab, setActiveTab] = useState("overview");
	const [apiStatus, setApiStatus] = useState("checking...");
	const [apiUrl] = useState(
		process.env.NEXT_PUBLIC_API_URL ||
			"https://contentr-production.up.railway.app"
	);

	useEffect(() => {
		const testConnection = async () => {
			try {
				console.log("Testing API connection to:", apiUrl);
				const response = await fetch(`${apiUrl}/health`);
				if (response.ok) {
					const data = await response.json();
					setApiStatus("healthy");
					console.log("API connection successful:", data);
				} else {
					setApiStatus("error");
					console.error("API response not ok:", response.status);
				}
			} catch (error) {
				setApiStatus("disconnected");
				console.error("API connection failed:", error);
			}
		};

		testConnection();
	}, [apiUrl]);

	const getStatusColor = () => {
		switch (apiStatus) {
			case "healthy":
				return "bg-green-500";
			case "disconnected":
				return "bg-red-500";
			case "error":
				return "bg-yellow-500";
			default:
				return "bg-gray-500";
		}
	};

	const getStatusText = () => {
		switch (apiStatus) {
			case "healthy":
				return "text-green-600";
			case "disconnected":
				return "text-red-600";
			case "error":
				return "text-yellow-600";
			default:
				return "text-gray-600";
		}
	};

	const statsCards = [
		{
			title: "Content Planned",
			value: "8",
			change: "+12%",
			icon: Calendar,
			gradient: "from-blue-500 to-blue-600",
			bg: "bg-blue-50",
			iconColor: "text-blue-600",
		},
		{
			title: "Avg Engagement",
			value: "4.5%",
			change: "+2.5%",
			icon: TrendingUp,
			gradient: "from-green-500 to-green-600",
			bg: "bg-green-50",
			iconColor: "text-green-600",
		},
		{
			title: "Total Reach",
			value: "18.5K",
			change: "+15%",
			icon: Users,
			gradient: "from-purple-500 to-purple-600",
			bg: "bg-purple-50",
			iconColor: "text-purple-600",
		},
		{
			title: "Opportunities",
			value: "8",
			change: "+3",
			icon: Brain,
			gradient: "from-orange-500 to-orange-600",
			bg: "bg-orange-50",
			iconColor: "text-orange-600",
		},
	];

	const tabs = [
		{ id: "overview", name: "Overview", icon: BarChart3 },
		{ id: "gaps", name: "Content Gaps", icon: Target },
		{ id: "calendar", name: "Calendar", icon: Calendar },
		{ id: "automation", name: "Automation", icon: Zap },
	];

	const apiDemos = [
		{
			title: "Content Gap Analysis",
			description:
				"AI identifies high-opportunity content topics using competitor analysis",
			url: `${apiUrl}/api/v1/analysis/content-gaps-sync?niche=API%20security`,
			icon: Target,
			gradient: "from-blue-500 to-cyan-500",
			feature: "Vector Search + LLM Analysis",
		},
		{
			title: "Content Calendar Generation",
			description:
				"Generate 30-day content strategy with performance predictions",
			url: `${apiUrl}/api/v1/calendar/generate-sync?niche=DevOps&days=7`,
			icon: Calendar,
			gradient: "from-purple-500 to-pink-500",
			feature: "Multi-step AI Workflow",
		},
		{
			title: "Interactive API Documentation",
			description: "Explore all endpoints with live testing interface",
			url: `${apiUrl}/docs`,
			icon: ExternalLink,
			gradient: "from-green-500 to-teal-500",
			feature: "FastAPI + TiDB Integration",
		},
	];

	return (
		<div className="min-h-screen bg-gradient-to-br from-gray-50 to-gray-100">
			{/* Header */}
			<header className="bg-white/80 backdrop-blur-md shadow-sm border-b border-gray-200/50 sticky top-0 z-50">
				<div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
					<div className="flex justify-between items-center py-4">
						<div className="flex items-center space-x-3">
							<div className="w-8 h-8 bg-gradient-to-br from-blue-500 to-purple-600 rounded-lg flex items-center justify-center">
								<Sparkles className="w-5 h-5 text-white" />
							</div>
							<div>
								<h1 className="text-2xl font-bold bg-gradient-to-r from-gray-900 to-gray-700 bg-clip-text text-transparent">
									Contentr
								</h1>
								<p className="text-sm text-gray-500">
									AI-powered content automation
								</p>
							</div>
						</div>
						<div className="flex items-center space-x-4">
							<div className="flex items-center space-x-2 px-4 py-2 bg-white rounded-full shadow-sm border border-gray-200">
								<div
									className={`w-2 h-2 rounded-full ${getStatusColor()}`}
								></div>
								<span className="text-sm font-medium text-gray-700">API:</span>
								<span className={`text-sm font-semibold ${getStatusText()}`}>
									{apiStatus}
								</span>
							</div>
							<button className="bg-gradient-to-r from-blue-600 to-purple-600 text-white px-6 py-2 rounded-full font-medium hover:from-blue-700 hover:to-purple-700 transition-all duration-200 shadow-lg hover:shadow-xl transform hover:-translate-y-0.5">
								Start Free Trial
							</button>
						</div>
					</div>
				</div>
			</header>

			{/* Hero Banner */}
			<div className="relative bg-gradient-to-r from-blue-600 via-purple-600 to-blue-800 text-white py-16 overflow-hidden">
				<div className="absolute inset-0 bg-black/10"></div>
				<div className="absolute inset-0">
					<div className="absolute top-10 left-10 w-72 h-72 bg-white/10 rounded-full blur-3xl"></div>
					<div className="absolute bottom-10 right-10 w-96 h-96 bg-purple-300/20 rounded-full blur-3xl"></div>
				</div>
				<div className="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
					<div className="text-center">
						<h2 className="text-4xl md:text-5xl font-bold mb-4 leading-tight">
							Agentic AI for
							<span className="block bg-gradient-to-r from-yellow-300 to-orange-300 bg-clip-text text-transparent">
								Content Automation
							</span>
						</h2>
						<p className="text-xl opacity-90 mb-8 max-w-3xl mx-auto">
							The first AI system that autonomously manages your entire content
							strategy - from research to publication
						</p>
						<div className="flex flex-wrap justify-center gap-6 text-sm mb-6">
							{[
								"Multi-step AI workflow",
								"TiDB vector search",
								"Real-world automation",
								"Production SaaS",
							].map((feature, index) => (
								<div
									key={index}
									className="flex items-center space-x-2 bg-white/20 backdrop-blur-md rounded-full px-4 py-2"
								>
									<CheckCircle className="w-4 h-4" />
									<span>{feature}</span>
								</div>
							))}
						</div>
						<div className="text-sm opacity-75 font-mono bg-black/20 backdrop-blur-md rounded-lg px-4 py-2 inline-block">
							Backend API: {apiUrl}
						</div>
					</div>
				</div>
			</div>

			{/* API Demo Section */}
			<div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16">
				<div className="text-center mb-12">
					<h3 className="text-3xl font-bold text-gray-900 mb-4">
						🧪 Live API Demonstration
					</h3>
					<p className="text-xl text-gray-600 max-w-3xl mx-auto">
						Experience our agentic AI in action. Each endpoint showcases
						sophisticated multi-step workflows that go far beyond simple Q&A.
					</p>
				</div>

				<div className="grid grid-cols-1 md:grid-cols-3 gap-8 mb-16">
					{apiDemos.map((demo, index) => {
						const Icon = demo.icon;
						return (
							<a
								key={index}
								href={demo.url}
								target="_blank"
								rel="noopener noreferrer"
								className="group relative bg-white rounded-2xl shadow-lg hover:shadow-2xl transition-all duration-300 overflow-hidden transform hover:-translate-y-2"
							>
								<div
									className={`absolute inset-0 bg-gradient-to-br ${demo.gradient} opacity-5 group-hover:opacity-10 transition-opacity`}
								></div>
								<div className="relative p-8">
									<div
										className={`inline-flex items-center justify-center w-12 h-12 bg-gradient-to-br ${demo.gradient} rounded-xl mb-6 group-hover:scale-110 transition-transform`}
									>
										<Icon className="w-6 h-6 text-white" />
									</div>
									<h4 className="text-xl font-bold text-gray-900 mb-3 group-hover:text-blue-600 transition-colors">
										{demo.title}
									</h4>
									<p className="text-gray-600 mb-4 leading-relaxed">
										{demo.description}
									</p>
									<div className="flex items-center justify-between">
										<span className="text-sm font-medium text-blue-600 bg-blue-50 px-3 py-1 rounded-full">
											{demo.feature}
										</span>
										<div className="flex items-center text-blue-600 group-hover:text-blue-700 transition-colors">
											<span className="text-sm font-medium mr-1">Test API</span>
											<ArrowRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
										</div>
									</div>
								</div>
							</a>
						);
					})}
				</div>

				{/* Navigation Tabs */}
				<div className="bg-white rounded-2xl shadow-lg border border-gray-200/50 mb-8 overflow-hidden">
					<div className="flex border-b border-gray-200">
						{tabs.map((tab) => {
							const Icon = tab.icon;
							return (
								<button
									key={tab.id}
									onClick={() => setActiveTab(tab.id)}
									className={`flex-1 flex items-center justify-center space-x-2 py-4 px-6 font-medium text-sm transition-all duration-200 ${
										activeTab === tab.id
											? "bg-gradient-to-r from-blue-50 to-purple-50 text-blue-600 border-b-2 border-blue-500"
											: "text-gray-500 hover:text-gray-700 hover:bg-gray-50"
									}`}
								>
									<Icon size={18} />
									<span>{tab.name}</span>
								</button>
							);
						})}
					</div>

					<div className="p-8">
						{activeTab === "overview" && (
							<div className="space-y-8">
								{/* Stats Cards */}
								<div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
									{statsCards.map((stat, index) => {
										const Icon = stat.icon;
										return (
											<div
												key={index}
												className="relative bg-white rounded-xl border border-gray-200/50 p-6 hover:shadow-lg transition-all duration-200 group"
											>
												<div className="flex items-center justify-between mb-4">
													<div
														className={`p-3 rounded-xl ${stat.bg} group-hover:scale-110 transition-transform`}
													>
														<Icon className={`w-6 h-6 ${stat.iconColor}`} />
													</div>
													<div className="text-right">
														<p className="text-2xl font-bold text-gray-900">
															{stat.value}
														</p>
														<p className="text-sm text-green-600 font-medium">
															{stat.change}
														</p>
													</div>
												</div>
												<p className="text-sm font-medium text-gray-600">
													{stat.title}
												</p>
												<p className="text-xs text-gray-500 mt-1">
													from last week
												</p>
											</div>
										);
									})}
								</div>

								{/* Agentic Workflow */}
								<div className="bg-gradient-to-br from-gray-50 to-white rounded-xl border border-gray-200/50 p-8">
									<h3 className="text-2xl font-bold text-gray-900 mb-6 text-center">
										🧠 Agentic AI Workflow
									</h3>
									<div className="grid grid-cols-2 md:grid-cols-6 gap-4">
										{[
											{
												step: "1. Data Ingestion",
												desc: "Collect & embed content",
											},
											{
												step: "2. Vector Search",
												desc: "Find similar patterns",
											},
											{
												step: "3. AI Analysis",
												desc: "Identify opportunities",
											},
											{
												step: "4. Strategy Generation",
												desc: "Create content plans",
											},
											{ step: "5. Auto Execution", desc: "Schedule & publish" },
											{ step: "6. Optimization", desc: "Learn & improve" },
										].map((item, index) => (
											<div
												key={index}
												className="text-center group"
											>
												<div className="bg-gradient-to-br from-blue-500 to-purple-600 text-white p-4 rounded-xl mb-3 group-hover:scale-105 transition-transform shadow-lg">
													<div className="font-bold text-sm mb-1">
														{item.step}
													</div>
													<div className="text-xs opacity-90">{item.desc}</div>
												</div>
												{index < 5 && (
													<ArrowRight
														className="mx-auto text-gray-400 group-hover:text-blue-500 transition-colors"
														size={16}
													/>
												)}
											</div>
										))}
									</div>
								</div>
							</div>
						)}

						{activeTab === "gaps" && (
							<div className="text-center space-y-6">
								<div className="max-w-2xl mx-auto">
									<h3 className="text-2xl font-bold text-gray-900 mb-4">
										🎯 Content Gap Analysis
									</h3>
									<p className="text-gray-600 mb-8">
										Our AI analyzes competitor content using vector similarity
										search to identify high-opportunity topics you're missing.
									</p>
								</div>
								<a
									href={`${apiUrl}/api/v1/analysis/content-gaps-sync?niche=B2B%20SaaS`}
									target="_blank"
									rel="noopener noreferrer"
									className="inline-flex items-center space-x-3 px-8 py-4 bg-gradient-to-r from-blue-600 to-purple-600 text-white rounded-xl hover:from-blue-700 hover:to-purple-700 transition-all duration-200 shadow-lg hover:shadow-xl transform hover:-translate-y-1"
								>
									<Play className="w-5 h-5" />
									<span className="font-semibold">
										Run Content Gap Analysis
									</span>
									<ExternalLink className="w-4 h-4" />
								</a>
							</div>
						)}

						{activeTab === "calendar" && (
							<div className="text-center space-y-6">
								<div className="max-w-2xl mx-auto">
									<h3 className="text-2xl font-bold text-gray-900 mb-4">
										📅 AI Content Calendar
									</h3>
									<p className="text-gray-600 mb-8">
										Generate comprehensive content strategies with performance
										predictions, optimal timing, and detailed briefs.
									</p>
								</div>
								<a
									href={`${apiUrl}/api/v1/calendar/generate-sync?niche=DevOps&days=30`}
									target="_blank"
									rel="noopener noreferrer"
									className="inline-flex items-center space-x-3 px-8 py-4 bg-gradient-to-r from-purple-600 to-pink-600 text-white rounded-xl hover:from-purple-700 hover:to-pink-700 transition-all duration-200 shadow-lg hover:shadow-xl transform hover:-translate-y-1"
								>
									<Calendar className="w-5 h-5" />
									<span className="font-semibold">
										Generate 30-Day Calendar
									</span>
									<ExternalLink className="w-4 h-4" />
								</a>
							</div>
						)}

						{activeTab === "automation" && (
							<div className="space-y-8">
								<div className="text-center max-w-2xl mx-auto">
									<h3 className="text-2xl font-bold text-gray-900 mb-4">
										⚡ Automation Dashboard
									</h3>
									<p className="text-gray-600 mb-8">
										End-to-end workflow automation with real-time monitoring and
										performance optimization.
									</p>
								</div>
								<div className="grid grid-cols-1 md:grid-cols-3 gap-6">
									{[
										{
											title: "6 Posts Scheduled",
											desc: "Next: Today at 9:00 AM",
											icon: CheckCircle,
											color: "green",
										},
										{
											title: "18.5K Projected Reach",
											desc: "This week's content",
											icon: Activity,
											color: "blue",
										},
										{
											title: "15 Hours Saved",
											desc: "This month",
											icon: Zap,
											color: "purple",
										},
									].map((item, index) => {
										const Icon = item.icon;
										const colors = {
											green: {
												bg: "bg-green-50",
												icon: "text-green-600",
												border: "border-green-200",
											},
											blue: {
												bg: "bg-blue-50",
												icon: "text-blue-600",
												border: "border-blue-200",
											},
											purple: {
												bg: "bg-purple-50",
												icon: "text-purple-600",
												border: "border-purple-200",
											},
										};
										return (
											<div
												key={index}
												className={`text-center p-6 ${
													colors[item.color].bg
												} rounded-xl border ${colors[item.color].border}`}
											>
												<Icon
													className={`mx-auto ${colors[item.color].icon} mb-3`}
													size={32}
												/>
												<h4 className="font-bold text-gray-900 mb-1">
													{item.title}
												</h4>
												<p className="text-sm text-gray-600">{item.desc}</p>
											</div>
										);
									})}
								</div>
							</div>
						)}
					</div>
				</div>
			</div>

			{/* Footer */}
			<footer className="bg-gradient-to-r from-gray-900 to-black text-white py-12">
				<div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
					<div className="mb-6">
						<p className="text-gray-300 text-lg">
							Contentr: Agentic AI for Real-World Content Automation
						</p>
					</div>
					<div className="flex flex-wrap justify-center gap-8 text-sm mb-6">
						<div className="flex items-center space-x-2">
							<CheckCircle className="w-4 h-4 text-green-400" />
							<span>Multi-step AI workflow</span>
						</div>
						<div className="flex items-center space-x-2">
							<CheckCircle className="w-4 h-4 text-green-400" />
							<span>TiDB Serverless integration</span>
						</div>
						<div className="flex items-center space-x-2">
							<CheckCircle className="w-4 h-4 text-green-400" />
							<span>Production-ready SaaS</span>
						</div>
						<div className="flex items-center space-x-2">
							<CheckCircle className="w-4 h-4 text-green-400" />
							<span>Real-world impact</span>
						</div>
					</div>
					<div className="text-sm text-gray-400">
						Built with FastAPI • TiDB Serverless • OpenAI • Next.js
					</div>
				</div>
			</footer>
		</div>
	);
}
